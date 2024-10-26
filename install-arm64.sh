curl -L https://github.com/zgoat/goatcounter/releases/download/v2.5.0/goatcounter-v2.5.0-linux-arm64.gz -o goatcounter.gz

# It comes in a compress files so we need to extract it
gunzip goatcounter.gz

# By default, the file doesn't come with execution permission
# and we can change that using chmod
chmod +x goatcounter 
