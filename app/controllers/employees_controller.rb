class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show update destroy ]

  def index
    @employees = Employee.all

    render json: @employees
  end


  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end



def tax_deduction
  employees = Employee.all 
  
  deductions = employees.map do |employee|

    total_salary = employee.Salary * 12
    
    tax_amount = calculate_tax(total_salary)
    
    cess_amount = calculate_cess(total_salary)
    
    {
      employee_id: employee.Employee_id,
      first_name: employee.FirstName,
      last_name: employee.lastName,
      yearly_salary: total_salary,
      tax_amount: tax_amount,
      cess_amount: cess_amount
    }
  end
  
  render json: deductions
end

 

  private
   
    def set_employee
      @employee = Employee.find(params[:id])
    end

   
    def employee_params
      params.require(:employee).permit(:Employee, :ID, :FirstName, :lastName, :Email, :PhoneNumber, :DOJ, :Salary)
    end


def calculate_total_salary(employee)
  doj = employee.date_of_joining
  months_worked = ((Date.today.year - doj.year) * 12) + (Date.today.month - doj.month)
  
  if Date.today.day < doj.day
    months_worked -= 1
  end
  
  if doj >= Date.new(Date.today.year, 4, 1)
    months_worked -= 1
  end
  
  total_salary = employee.monthly_salary * months_worked
  
  total_salary
end

def calculate_tax(yearly_salary)
  tax_slabs = [
    [250000, 0],
    [500000, 0.05],
    [1000000, 0.1],
    [Float::INFINITY, 0.2]
  ]
  
  tax_amount = 0
  
  tax_slabs.each do |limit, rate|
    if yearly_salary <= limit
      tax_amount += yearly_salary * rate
      break
    else
      tax_amount += limit * rate
      yearly_salary -= limit
    end
  end
  
  tax_amount
end

def calculate_cess(yearly_salary)
  return 0 if yearly_salary <= 2500000
  
  cess_amount = (yearly_salary - 2500000) * 0.02
end
end