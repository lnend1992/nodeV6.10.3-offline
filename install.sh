#!/bin/bash
## install nodejs

FILENAME="node-v6.10.3"

INSTALL_PATH="/usr/local/src"
BIN_PATH="/bin"
DATE=$(date +%Y%m%d)

echo -e "\nnode-v6.10.3 install......\n"

mkdir -p ./log
mkdir -p ./temp

cp -R $FILENAME* ./temp

## 删除已存在文件
rm -rf $INSTALL_PATH/node-v6.10.3

tar xvf $FILENAME.tar.gz -C ./temp/ 1>>./log/install-$DATE.log

cp -R ./temp/$FILENAME $INSTALL_PATH/node-v6.10.3

rm -rf ./temp

## 创建环境变量软连接
for LN_FILE in $INSTALL_PATH/$FILENAME/bin/*
do
    if test -f $LN_FILE
    then

        ##  提取文件名
        LN_FILE_NAME=${LN_FILE##*/};

        ## 删除已存在链接
        rm -rf $BIN_PATH/$LN_FILE_NAME

        ## 创建新链接
        ln -s $LN_FILE $BIN_PATH/$LN_FILE_NAME

        ## 清空并重建当前hash值
        hash -l 1>>./log/install-$DATE.log

        echo -e "     "$LN_FILE_NAME" ---> "$BIN_PATH"/"$LN_FILE_NAME

    fi
done

echo -e "\nsuccess...... \n"
node -v
