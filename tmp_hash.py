import bcrypt
print(bcrypt.hashpw(b'admin123', bcrypt.gensalt()).decode())
print(bcrypt.hashpw(b'user123', bcrypt.gensalt()).decode())
