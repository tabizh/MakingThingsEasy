** Created By Tabizh to save you time :) **
#Clean the project
  make clean
  echo "Project cleaned."
  echo
# Build the project
  make
  echo "Project built."
  echo
# Run static analysis
  make static
  echo "Static analysis completed."
  echo         
# Run exe anaylsis
  make exe
  echo "exe  analysis completed."
  echo
# Build Docker image
  make docker
  echo "Docker image built."
  echo        
# Tag the Docker image
  sudo docker tag emscli:latest docker-registry.com:5000/emscli:tab1
  echo "Docker image tagged."
  echo                     
# Add a sleep for 5 seconds (adjust as needed)
  sleep 5
                                  
# Save the Docker image as a tar file
  sudo docker save docker-registry.com:5000/emscli:tab1 -o emscli_tab.tar
  echo "Docker image saved as a tar file."

  SOURCE_FILE="emscli_tab.tar"
  DESTINATION_USER="oltausr"
  DESTINATION_HOST="172.XX.XXX.XXX" 
  #DESTINATION_PATH="/path/to/destination/directory"
  echo
  #sudo sshpass -p "PasswordOlt" scp -r "$SOURCE_FILE" "$DESTINATION_USER@$DESTINATION_HOST:"
  sudo sshpass -p "PasswordOlt" pv "$SOURCE_FILE" | sshpass -p "PasswordOlt" ssh "$DESTINATION_USER@$DESTINATION_HOST" "cat > $(basename $SOURCE_FILE)"
  echo 
echo "Image Sent to OLT"
