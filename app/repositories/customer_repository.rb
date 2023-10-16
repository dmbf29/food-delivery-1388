class CustomerRepository < BaseRepository
  def build_element(attributes)
    attributes[:id] = attributes[:id].to_i
    Customer.new(attributes)
  end
end
