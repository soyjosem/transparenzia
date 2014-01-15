require 'json'
require 'iconv'

class AgreementImporter
  attr_accessor :keys, :data
  @keys
  @data
  def initialize(doc)
    i = Iconv.new('UTF-8','LATIN1')
    doc = i.iconv(doc)
    doc = doc.gsub('`','')
    @data = JSON.parse(doc)
    @keys = @data.first.keys
  end

  def save
    Agreement.destroy_all(:year => @data.first['Año'])
    @data.each do |item|
      begin
        agreement = Agreement.new(
            :code => item['Número'],
            :year => item['Año'], 
            :section => item['Sección'], 
            :title => item['Título'], 
            :agreement_date => convert_text_to_date(item['FechaAcuerdo']),
            :signature_date => convert_text_to_date(item['FechaFirma']),
            :validity_date => convert_text_to_date(item['FechaVigencia']), 
            :signatories => item['Firmantes'], 
            :number_of_signatories => item['Firmantes'].split("/").size, 
            :dga_contribution => item['AportacionDGA'], 
            :another_contributions => item['OtrasAportaciones'],
            :amount => item['Cuantia'],
            :addendums => item['Addendas'],
            :observations => item['Observaciones'],
            :notes => item['Notasmarginales'],
            :pdf_url => item['UrlPdf'].gsub("´", "").strip()
          )
        total_of_amount(agreement)
        if agreement.year >= 2008 
          total_dga_contribution(agreement)
          dga_contribution_percentage(agreement)
        end
        agreement.save!
      rescue Exception => e
        puts "Error for #{item}"
        raise e
      end
    end
  end

private

  def convert_text_to_date(text)
    begin
      date = (text!="") ? Date.strptime(text, "%Y%m%d"): nil
    rescue
      date = nil
    end
    if date and date.gregorian?
      date
    end
  end

  def total_of_amount(agreement)
    agreement.total_amount = sumatory_of_numbers_in_string(agreement.amount)
  end

  def total_dga_contribution(agreement)
    agreement.total_dga_contribution = sumatory_of_numbers_in_string(agreement.dga_contribution)
  end

  def dga_contribution_percentage(agreement)
    if agreement.total_amount > 0
      agreement.dga_contribution_percentage = (agreement.total_dga_contribution / agreement.total_amount)
    end
  end

  def sumatory_of_numbers_in_string(string)
    total = 0
    if string and not string.empty?
      string = clean_number_format(string)
      if is_a_number?(string)
        total += string.to_f
      else
        numbers = get_all_the_numbers_in_string(string)
        unless numbers.empty?
          numbers.each do |number|
            number = number.to_f
            if number > 1000 #if is less than 1000 euros is desestimated, look like a date year
              total +=  number
            end
          end
        end
      end
    end
    total
  end

  def is_a_number?(string)
    /\A[-+]?[0-9]*\.?[0-9]+\Z/.match(string)
  end

  def get_all_the_numbers_in_string(string)
    string.scan /[-+]?[0-9]+\.?[0-9]+/
  end

  def clean_number_format(string)
    string.gsub!('.','') #for clean thousands separation in some number formats
    string.gsub!(',','.') #for change comma decimal separation to dots
    string.strip
  end
end