# spec/trig_calculator_spec.rb

require "spec_helper"
require 'trig_calculator'

RSpec.describe TrigCalculator do
  it 'calculates sine' do
    expect(TrigCalculator.sin(Math::PI / 2)).to be_within(0.01).of(1.0)
  end

  it 'calculates cosine' do
    expect(TrigCalculator.cos(0)).to be_within(0.01).of(1.0)
  end

  it 'calculates tangent' do
    expect(TrigCalculator.tan(Math::PI / 4)).to be_within(0.01).of(1.0)
  end

  it 'calculates cotangent' do
    expect(TrigCalculator.cot(Math::PI / 4)).to be_within(0.01).of(1.0)
  end

  it 'raises an error for cotangent at multiples of PI/2' do
    expect { TrigCalculator.cot(Math::PI / 2) }.to raise_error(ZeroDivisionError, 'Cotangent is undefined for this angle')
  end

  it 'calculates secant' do
    expect(TrigCalculator.sec(0)).to be_within(0.01).of(1.0)
  end

  it 'raises an error for secant at odd multiples of PI/2' do
    expect { TrigCalculator.sec(Math::PI / 2) }.to raise_error(ZeroDivisionError, 'Secant is undefined for this angle')
  end

  it 'calculates cosecant' do
    expect(TrigCalculator.csc(Math::PI / 2)).to be_within(0.01).of(1.0)
  end

  it 'raises an error for cosecant at multiples of PI' do
    expect { TrigCalculator.csc(0) }.to raise_error(ZeroDivisionError, 'Cosecant is undefined for this angle')
  end

  # Крайові випадки
  it 'calculates sine at 0' do
    expect(TrigCalculator.sin(0)).to be_within(0.01).of(0.0)
  end

  it 'calculates cosine at 0' do
    expect(TrigCalculator.cos(0)).to be_within(0.01).of(1.0)
  end

  it 'calculates tangent at 0' do
    expect(TrigCalculator.tan(0)).to be_within(0.01).of(0.0)
  end
end
