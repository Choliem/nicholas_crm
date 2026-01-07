# Demo Account
manager = User.create!(name: "Manager Budi", email: "manager@smart.com", password: "password123", role: "manager")
sales = User.create!(name: "Sales Andi", email: "sales@smart.com", password: "password123", role: "sales")

# Demo product
Product.create!([
  { name: "Smart Home 50Mbps", description: "Internet cepat untuk rumah", price: 350000 },
  { name: "Smart Office 100Mbps", description: "Dedicated line untuk kantor", price: 1500000 }
])

# Demo Lead
Lead.create!(name: "Nicholas Corp", email: "info@nicholas.com", phone: "0812345678", address: "Surabaya", status: "Prospect")