require "employee"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name,funding,salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        return true if @salaries.include?(title)
        false
    end

    def >(startup)
        return true if @funding > startup.funding
        false
    end

    def hire(name,title)
        if salaries.has_key?(title)
            @employees << Employee.new(name,title)
        else
            raise ArugmentError.new
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @salaries[employee.title] != nil && @salaries[employee.title] <= @funding
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else
            raise ArugmentError.new
        end
    end

    def payday
        @employees.each do |x|
            pay_employee(x)
        end
    end

    def average_salary
        sum = 0
        count = 0
        @employees.each do |x|
            count += 1
            sum += @salaries[x.title]
        end
        sum/count.to_f
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each_pair do |k,v|
            if !@salaries.has_key?(k)
                @salaries[k] = v
            end
        end
        startup.employees.each do |x|
            @employees<<x
        end
        startup.close
    end

end
