import base64
from cryptography.fernet import Fernet

def generate_key():
    """Generate a key for encryption and decryption."""
    return Fernet.generate_key().decode()

def encrypt_text(text, key):
    """Encrypt the given text using the key."""
    encoded_text = text.encode()
    f = Fernet(key.encode())
    encrypted_text = f.encrypt(encoded_text)
    return base64.b64encode(encrypted_text).decode()

def decrypt_text(encrypted_text, key):
    """Decrypt the given encrypted text using the key."""
    decoded_text = base64.b64decode(encrypted_text.encode())
    f = Fernet(key.encode())
    decrypted_text = f.decrypt(decoded_text)
    return decrypted_text.decode()