# encoding: utf-8
#
# Copyright (c) 2007 Bart Teeuwisse
# Copyright (c) 2010 - 2011 Martin Kozák
#

require 'openssl'
require 'base64'

module OpenSSL
    module PKey
    
        ##
        # Encrypts and decrypts data of arbitrary length using RSA 
        # cyphers. Fixed and much faster fork of "crypto64" gem.
        #
        
        class RSA

            ##
            # Matches the OpenSSH key bit count indicator.
            #
            
            BIT_MATCHER = /(\d+) bit/
            
            ##
            # Holds size of the key.
            #
            
            @size
            
            ##
            # Holds encrypting block size.
            #
            
            @encrypt_block_size
            
            ##
            # Holds decrypting block size.
            #
            
            @decrypt_block_size
            
            ##
            # Read the length of the private key.
            # @return [Integer] size (length) of the private key
            #
            
            def size
                if @size.nil?
                    @size = self.class::BIT_MATCHER.match(self.to_text)[1].to_i
                end

                return @size
            end

            ##
            # Calculate the block size when encrypting.
            # @return [Integer] block size
            #
            
            def encrypt_block_size
                if @encrypt_block_size.nil?
                    @encrypt_block_size = (self.size / 8) - 14
                end
                
                return @encrypt_block_size
            end

            ##
            # Calculate the block size when decrypting.
            # @return [Integer] block size
            #
            
            def decrypt_block_size
                if @decrypt_block_size.nil?
                    @decrypt_block_size = (self.size / 8) - 1
                end
            
                return @decrypt_block_size
            end

            ##
            # Encrypt and base64 encode data of arbitrary length.
            #
            # @param [String] str string for encrypting
            # @return [String] encrypted string
            #
            
            def encrypt64(str)
                enc = ''
                encrypt_block_size = self.encrypt_block_size
            
                while str.length > encrypt_block_size
                    enc << self.public_encrypt(str[0..encrypt_block_size])
                    str = str[encrypt_block_size + 1..-1]
                end 
            
                if str.length > 0
                    enc << self.public_encrypt(str[0..encrypt_block_size])
                end
            
                return Base64.encode64(enc)
            end

            ##
            # Decrypt and base64 decode data of arbitrary length.
            #
            # @param [String] str string for decrypting
            # @return [String] decrypted string
            #
            
            def decrypt64(str)
                dec = ''
                str = Base64.decode64(str)
                decrypt_block_size = self.decrypt_block_size
            
                while str.length > 0
                    dec << self.private_decrypt(str[0..decrypt_block_size])
                    if str.length > decrypt_block_size
                        str = str[decrypt_block_size + 1..-1]
                    end
                end
            
                return dec
            end
          
        end
    end
end
