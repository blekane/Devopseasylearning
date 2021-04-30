import getpass, os
# import crypt

DB_USER=input('Enter the DB username: ')
DB_PASS=getpass.getpass(prompt='Enter the user DB password: ')
print(f'The DB username is {DB_USER} and his password is {DB_PASS}')

# encPass = crypt.crypt(DB_PASS)
# print(f'The encryption password is: {encPass }')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                