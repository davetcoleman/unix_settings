### Search system ignoring errors

    gr NEEDLE 2> /dev/null

### Upper case all file extensions in a folder:

    for i in *.dae; do ext=$(echo ${i##*.} | tr '[:lower:]' '[:upper:]'); name=$(basename "$i" ".${i##*.}").$ext; cp $i ../$name; done

