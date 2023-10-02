# Create a self-signed certificate for CA service:
openssl genrsa -out ca.key 2048                                         #--------- create a CA key
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr      #--------- create a certificate signing request
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt                #--------- sighn a signing request via ca.key
# This certificate is self-signed by CA (using its own private key), 
# but for signing all other certificates in the cluster we will use this CA key and route certificate.
 
# Generating client certificate for admin user
openssl genrsa -out admin.key 2048                                      #--------- create a admin key
openssl req -new -key admin.key -subj "/CN=kube-admin" -out ca.csr      #--------- create a certificate signing request
openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt
# To identified admin user from any other users we can add the group spesification to the CN field
openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:masters" -out ca .csr    #--------- system:masters is a group name

# By this way create clients certificates for kube controller manager, kube scheduler, kube proxy




