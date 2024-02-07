class Employee < ApplicationRecord
    validates :FirstName,    presence: true
    validates :lastName,     presence: true
    validates :Salary, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validate :validate_date_of_joining
  
  private
  
  def validate_date_of_joining
    if self.DOJ.present? && !DOJ.is_a?(Date)
      errors.add(:DOJ, "must be a valid date")
    end
  end
end
