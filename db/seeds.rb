# db/seeds.rb
User.destroy_all
Product.destroy_all

# Membuat Akun Demo (Gunakan Role yang kita diskusikan)
User.create!([
  { name: "Manager Budi", email: "manager@smart.com", password: "password123", role: "manager", phone: "0811111111" },
  { name: "Sales Andi", email: "sales@smart.com", password: "password123", role: "sales", phone: "0822222222" }
])

# Membuat Produk Layanan Internet
Product.create!([
  { name: "Smart Home 50Mbps", description: "Internet rumah stabil", price: 350000 },
  { name: "Smart Biz 100Mbps", description: "Internet dedicated bisnis", price: 1200000 }
])

puts "Data Seed berhasil dimasukkan!"