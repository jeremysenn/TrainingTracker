class Biosignature < ActiveRecord::Base
  attr_accessible :sex, :date, :client_id, :age, :height, :height_units, :weight, :weight_units, :chin, :cheek, :pec, :tri, :subscap, :suprailiac, :midaxil, :umbilical, :knee, :calf, :quad, :ham, :waist, :hip

  after_initialize :init

  belongs_to :client
  has_one :album, :as => 'imageable'

  validates :date, :presence => true
  validates :age, :presence => true
  validates :height, :presence => true
  validates :weight, :presence => true
#  validates :chin, :presence => true
#  validates :cheek, :presence => true
#  validates :pec, :presence => true
#  validates :tri, :presence => true
#  validates :subscap, :presence => true
#  validates :suprailiac, :presence => true
#  validates :midaxil, :presence => true
#  validates :umbilical, :presence => true
#  validates :knee, :presence => true
#  validates :calf, :presence => true
#  validates :quad, :presence => true
#  validates :ham, :presence => true
#  validates :waist, :presence => true
#  validates :hip, :presence => true

  def init
    #will set the default value only if it's nil
    self.chin  ||= 0
    self.cheek  ||= 0
    self.pec  ||= 0
    self.tri  ||= 0
    self.subscap  ||= 0
    self.suprailiac  ||= 0
    self.midaxil  ||= 0
    self.umbilical  ||= 0
    self.knee  ||= 0
    self.calf  ||= 0
    self.quad  ||= 0
    self.ham  ||= 0
    self.waist  ||= 0
    self.hip  ||= 0
  end

  def sum_of_7
    pec + tri + subscap + suprailiac + midaxil + umbilical + quad
  end

  def sum_of_10
    chin + cheek + pec + tri + subscap + suprailiac + midaxil + umbilical + knee + calf
  end

  def sum_of_12
    chin + cheek + pec + tri + subscap + suprailiac + midaxil + umbilical + knee + calf + quad + ham
  end
  
  def sum_of_pec_umbilical_quad
    pec + umbilical + quad
  end

  def bodyfat_percent
    (4.95/bodydensity - 4.5) * 100
  end

  # MEN SEVEN SITE JACKSON POLLOCK ===> X = sum of 7 | BD = 1.11200000 - 0.00043499(X) + 0.00000055(X)(X) - 0.00028826 (Age)
  # WOMEN SEVEN SITE JACKSON POLLOCK ===> X = sum of 7 | BD = 1.097 - 0.00046971(X) + 0.00000056(X)(X) - 0.00012828(Age)
  def bodydensity
    if sex == 'Male'
      1.11200000 - 0.00043499 * sum_of_7 + (0.00000055 * sum_of_7**2) - (0.00028826 * age)
    elsif sex == 'Female'
      1.097 - 0.00046971 * sum_of_7 + (0.00000056 * sum_of_7**2) - (0.00012828 * age)
    end
  end

#  def women_bodydensity
#    1.097 - 0.00046971 * sum_of_7 + (0.00000056 * sum_of_7**2) - (0.00012828 * age)
#  end

  def lean_mass
    weight - fat_mass
  end

  def fat_mass
    bodyfat_percent/100 * weight
  end

  def pec_pvalue
    (pec - tri)/tri * 100
  end

  def subscap_pvalue
    ((subscap - 5) - tri)/tri * 100
  end

  def midaxil_pvalue
    (midaxil - tri)/tri * 100
  end

  def suprailiac_pvalue
    ((suprailiac - 5) - tri)/tri * 100
  end

  def umbilical_pvalue
    ((umbilical - 3) - tri)/tri * 100
  end

  def knee_pvalue
    (knee - tri)/tri * 100
  end

  def calf_pvalue
    (calf - tri)/tri * 100
  end

  def quad_pvalue
    (quad - tri)/tri * 100
  end

  def ham_pvalue
    ((ham - 1) - tri)/tri * 100
  end

  def priority_hash ## SORTED
    Hash["pec", pec_pvalue, "subscap", subscap_pvalue, "midaxil", midaxil_pvalue, "suprailiac", suprailiac_pvalue, "umbilical", umbilical_pvalue, "knee", knee_pvalue, "calf", calf_pvalue, "quad", quad_pvalue, "ham", ham_pvalue].sort {|a,b| a[1]<=>b[1]}.reverse
  end

  def priority_list
    priority_hash.first(3)
  end

  def waist_hip_ratio
    (waist/hip).round(2)
  end

end
