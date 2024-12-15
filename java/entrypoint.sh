#!/bin/bash

#
# Copyright (c) 2024 CSD
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Quét virus
LOG_PREFIX="\033[1m\033[33mconsole@minemelon~ \033[0m"
printf "${LOG_PREFIX} java -version\n"
java -version

JAVA_MAJOR_VERSION=$(java -version 2>&1 | grep -oP 'version "\K\d+')

if [[ "$MALWARE_SCAN" == "1" ]]; then
    if [[ "$JAVA_MAJOR_VERSION" -lt 17 || ! -f "/MCAntiMalware.jar" ]]; then
        echo -e "${LOG_PREFIX} Quét virus chỉ khả dụng với Java 17 trở lên, bỏ qua..."
    else
        echo -e "${LOG_PREFIX} Đang quét virus... (Quá trình này có thể mất thời gian)"
        java -jar /MCAntiMalware.jar --scanDirectory . --singleScan true --disableAutoUpdate true
        if [ $? -eq 0 ]; then
            echo -e "${LOG_PREFIX} Quét virus thành công"
        else
            echo -e "${LOG_PREFIX} Quét virus thất bại"
            exit 1
        fi
    fi
else
    echo -e "${LOG_PREFIX} Bỏ qua quét virus..."
fi

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "\033[1m\033[33mconsole@minemelon~ \033[0m%s\n" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}