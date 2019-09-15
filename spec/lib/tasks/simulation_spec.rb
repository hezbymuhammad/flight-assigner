require 'rails_helper'

describe 'simulation:queue' do
  include_context 'rake'

  it 'generate plane' do
    expect{
      subject.invoke
    }.to change {
      Plane.count
    }.by(1)
  end

  it 'generate 30 users' do
    expect{
      subject.invoke
    }.to change {
      User.count
    }.by(30)
  end

  it 'assign 30 seats' do
    subject.invoke

    expect(Seat.occupied.count).to eq(30)
  end
end
