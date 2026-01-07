# Membersihkan data lama agar tidak double
Project.destroy_all
Lead.destroy_all
Product.destroy_all
User.destroy_all

# 1. Create Users
admin = User.create!(name: "Super Admin", email: "admin@smart.com", username: "admin", password: "password123", role: "admin", phone: "0800000000", verified_at: Time.now)
manager = User.create!(name: "Manager Budi", email: "manager@smart.com", username: "manager", password: "password123", role: "manager", phone: "0811111111", verified_at: Time.now)
sales = User.create!(name: "Sales Andi", email: "sales@smart.com", username: "sales", password: "password123", role: "sales", phone: "0822222222", verified_at: Time.now)

# 2. Create Products
p1 = Product.create!(name: "Smart Home 50Mbps", description: "Internet rumah stabil", price: 350000)
p2 = Product.create!(name: "Smart Biz 100Mbps", description: "Internet dedicated bisnis", price: 1200000)
p3 = Product.create!(name: "Dedicated Fiber 1Gbps", description: "Solusi korporat", price: 15000000)

# 3. Create Leads (Prospek)
l1 = Lead.create!(name: "PT. Maju Jaya", email: "info@majujaya.com", phone: "021555666", address: "Sudirman, Jakarta", status: "Qualified", lat: -6.2088, long: 106.8456)
l2 = Lead.create!(name: "Bapak Budi Sudarsono", email: "budi@gmail.com", phone: "0812333444", address: "Griya Galaxy, Surabaya", status: "New", lat: -7.2575, long: 112.7521)
l3 = Lead.create!(name: "Cafe Kopi Senja", email: "kopi@senja.com", phone: "031999888", address: "Rungkut, Surabaya", status: "Contacted", lat: -7.3311, long: 112.7611)

# 4. Create Projects (Simulasi alur kerja)
# Project yang sudah Approved oleh Manager
Project.create!(lead: l1, product: p3, user: sales, status: "Approved", approved_at: 1.day.ago)
# Project yang masih Pending (menunggu Manager)
Project.create!(lead: l2, product: p1, user: sales, status: "Pending Approval")
# Project lainnya
Project.create!(lead: l3, product: p2, user: sales, status: "Pending Approval")

puts "🚀 UI/UX Demo Data Berhasil Dimasukkan!"