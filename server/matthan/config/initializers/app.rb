ERR_INVALID_PARAM = 100
ERR_OBJECT_NOT_FOUND = 101

FIXED_TIMEZONE = '+0700' # Vietnam
FIXED_TIMEZONE_OFFSET = 7 * 60

unless Owner.where(role: Owner::ROLE_MASTER_OWNER).exists?
  require 'digest/md5'
  Owner.create(name: 'Nguyễn Cao Vũ',
               email: 'caovuxy@gmail.com',
               password: Digest::MD5.hexdigest('temp123'),
               role: Owner::ROLE_MASTER_OWNER)
end

CAR_TYPES = [
  '5 chỗ',
  '7 chỗ',
  '30 chỗ',
  '49 chỗ'
]