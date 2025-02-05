library("stringr")
library("jsonlite")
storedM = list.dirs(path = "MUSIC", full.names = TRUE, recursive = TRUE)
num = str_count(storedM,"/")
#Finds all of the album sub-directories
(album.dirs <- storedM[which(num == 2)])
#Vector that stores each line of code to be executed
code.to.process = vector(mode = "character", length = 0)
for (curr.album in album.dirs)
{
  #Accumulates songs from current album
  stored_files = list.files(path = curr.album)
  #Identifies which files are .wav and subsets those that are not
  num1 = str_count(stored_files, ".wav")
  song.files = stored_files[which(num1 == 1)]
  #Iterates through each song within the current album
  for(curr.song in song.files)
  {
    #Quotations may need to be fixed
    comb1 = paste( '"',curr.album, "/", curr.song,'"', sep = "")
    
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
    file.output = paste('"',file.output,".json", '"', sep = "")
    #Creates vector of code to be processed
    code.to.process = c(code.to.process, paste("streaming_extractor_music.exe", comb1, file.output, sep = " "))
  }
}
#Puts code into .txt file
writeLines(text = code.to.process, con = "batfile.txt", sep = "\n")

#4
#Keeps track of whether a file is a Json (for second lab period)
num.ofJson = str_count(storedM, ".json")
files.ofJson = storedM[which(num.ofJson == 1)]

#for(curr.song in files.ofJson)
#{

#Manual declaration 
curr.song = "The Front Bottoms-Talon Of The Hawk-Au Revoir (Adios).json"

song.split = str_split(curr.song,"-")
song.split = song.split[[1]]
artist.name = song.split[1]
album.name = song.split[2]
song.name = song.split[3]
JSON.files = fromJSON(curr.song)
#Finds lowlevel values
JSON.lowlevel.files = JSON.files$lowlevel
average_loudness = JSON.lowlevel.files$average_loudness
spectral_energy_mean = JSON.lowlevel.files$spectral_energy$mean
#Finds rhythm values
JSON.rhythm.files = JSON.files$rhythm
danceability = JSON.rhythm.files$danceability
bpm = JSON.rhythm.files$bpm

#Finds other values outside of lowlevel and rhythm lists
key = JSON.files$tonal$key_key
key_scale = JSON.files$tonal$key_scale
length = JSON.files$metadata$audio_properties$length


#}


