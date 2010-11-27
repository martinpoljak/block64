require 'openssl'
require 'base64'

class Block64 < OpenSLL::PKey::RSA

  BIT_MATCHER = /(\d+) bit/
	
  @size
  @encrypt_block_size
  @decrypt_block_size
	
  # Read the length of the private key.
  def size
    if @size.nil?
      @size = self.class::BIT_MATCHER.match(self.to_text)[1].to_i
    end
    
    return @size
  end

  # Calculate the block size when encrypting.
  def encrypt_block_size
    if @encrypt_block_size.nil?
      @encrypt_block_size = (self.size / 8) - 14
    end
    
    return @encrypt_block_size
  end

  # Calculate the block size when decrypting.
  def decrypt_block_size
    if @decrypt_block_size.nil?
        (self.size / 8) - 1
    end
    
    return @decrypt_block_size
  end

  # Encrypt and base64 encode data of arbitrary length.
  def encrypt64(str)
    enc = ''
    str = str.dup
    encrypt_block_size = self.encrypt_block_size
    
    while str.length > encrypt_block_size
      enc << self.public_encrypt(str[0..encrypt_block_size])
      str.replace(str[self.encrypt_block_size + 1..-1])
    end 
    
    if str.length > 0
      enc << self.public_encrypt(str[0..encrypt_block_size])
    end
    
    return Base64.encode64(enc)
  end

  # Decrypt and base64 decode data of arbitrary length.
  def decrypt64(str)
    dec = ''
    str = Base64.decode64(str)
    decrypt_block_size = self.decrypt_block_size
    
    while str.length > 0
      dec << self.private_decrypt(str[0..decrypt_block_size])
      if str.length > decrypt_block_size
        str.replace(str[self.decrypt_block_size + 1..-1])
      end
    end
    
    return dec
  end
  
end
