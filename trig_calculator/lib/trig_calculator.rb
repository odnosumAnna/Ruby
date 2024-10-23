# frozen_string_literal: true

require_relative "trig_calculator/version"

# lib/trig_calculator.rb

module TrigCalculator
  def self.sin(angle)
    Math.sin(angle)
  end

  def self.cos(angle)
    Math.cos(angle)
  end

  def self.tan(angle)
    Math.tan(angle)
  end

  def self.cot(angle)
    if angle % (Math::PI / 2) == 0 && angle % Math::PI != 0
      raise ZeroDivisionError, 'Cotangent is undefined for this angle'
    end

    1.0 / tan(angle)
  end

  def self.sec(angle)
    if angle % (Math::PI / 2) == 0 && angle % Math::PI != 0
      raise ZeroDivisionError, 'Secant is undefined for this angle'
    end

    1.0 / cos(angle)
  end

  def self.csc(angle)
    if sin(angle).zero?
      raise ZeroDivisionError, 'Cosecant is undefined for this angle'
    end

    1.0 / sin(angle)
  end
end
