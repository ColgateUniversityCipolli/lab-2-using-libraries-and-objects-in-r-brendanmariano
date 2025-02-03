library("stringr")
storedM = list.dirs(path = "MUSIC", full.names = TRUE, recursive = TRUE)
print(storedM)

num = str_count(storedM,"/")
num

storedM[which(num == 2)]
album.dirs <- storedM[which(num == 2)]


#num2 = str_count(stored_files)


curr.album <- album.dirs[1]
#1
stored_files = list.files(path = curr.album)
num1 = str_count(stored_files, ".wav")
num1
song.files <- stored_files[which(num1 == 1)]
#2
code.to.process = vector(mode = "character", length = 0)
curr.song = song.files[1]
comb1 = paste(curr.album, curr.song, sep="/")

track.name = str_sub(curr.song, start = 1, end = -5)
track.split = str_split(track.name, "-")
track.split = track.split[[1]]
track.name = track.name[3]
print(track.name)

curr.song <- song.files[1]
#3





# vector_1 = vector(mode = "character", length = 0)
# for(i in length(storedM))
#   append(vector_1, which(num[i] == 2))
# 
# print(vector_1)
# 
# 
# 


