library("stringr")
storedM = list.dirs(path = "MUSIC", full.names = TRUE, recursive = TRUE)
print(storedM)

num = str_count(storedM,"/")
num
#Finds all of the album sub-directories
storedM[which(num == 2)]
album.dirs <- storedM[which(num == 2)]

print(album.dirs)

#num2 = str_count(stored_files)

for (curr.album in album.dirs)
{
  #Accumulates songs from current album
  stored_files = list.files(path = curr.album)
  print(stored_files)
  #Identifies which files are .wav and subsets those that are not
  num1 = str_count(stored_files, ".wav")
  song.files = stored_files[which(num1 == 1)]
  #Iterates through each song within the current album
  for(curr.song in song.files)
  {
    code.to.process = vector(mode = "character", length = 0)
    comb1 = paste(curr.album, curr.song, sep="/")
    #Removes the .wav from the track name
    track.name = str_sub(curr.song, start = 1, end = -5)
    #Finds the track name (Not including artist or anything else)
    track.split = str_split(track.name, "-")
    track.split = track.split[[1]]
    track.name = track.split[3]
    #Finds the current artist
    curr.artist = track.split[2]
    #Creates vector for desired file output
    file.output = vector(mode = "character", length = 0)
    #Extracts album name
    album.split = str_split(curr.album, "/")
    album.split = album.split[[1]]
    album.name = album.split[3]
    file.output = paste(curr.artist, album.name,track.name, sep = "-")
    #Creates code to be processed and puts into .txt file
    code.to.process = paste("streaming_extractor_music.exe", curr.song, file.output)
    #Opens the file in append mode so that batfile doesn't write over itself
    curr.file = file("batfile.txt", "a")
    writeLines(code.to.process, curr.file, sep = "\n")
    close(curr.file)
  }
}



