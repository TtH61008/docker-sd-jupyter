- WSL2上でGPUを認識させる（nvidia-smiができるようにする）
  - https://qiita.com/ksasaki/items/ee864abd74f95fea1efa
  > 現在は通常の Windows 用ドライバで OK です。なお、このドライバ、WSL 2 の Linux カーネル側 ではなく、ホストの Windows にインストールします。
- 多分windowsにドライバ入れればwsl側でnvidia-smiを使えるようになる...とのこと

- dockerのインストール
  - docker-desktopをインストールしておくでもよい
```bash
# ubuntuの場合
# aptの行き先を国内に向ける
$ sudo sed -i.bak -e "s/http:\/\/archive\.ubuntu\.com/http:\/\/jp\.archive\.ubuntu\.com/g" /etc/apt/sources.list

$ sudo apt-get update
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io
```

```bash
$ docker build -t diffusers-lab ./
# GPU無
$ docker run -it --rm -v ~/diffusers-workspace:/workspace -p 8888:8888 --name pytorch diffusers-lab jupyter lab --ip 0.0.0.0 --allow-root
# GPU有
$ docker run -d --rm --gpus all -v ~/diffusers-workspace:/workspace -v ~/.cache/huggingface:~/.cache/huggingface -p 8888:8888 --name pytorch diffusers-lab jupyter lab
# containerのpidが表示される
$ docker logs $PID
# tokenが表示されるのでlocalhost:8888に接続してログインに使う
```

- こちらにしたがってcolabのUIから接続する...とhuggingfaceのloginに失敗した。
  - https://www.kabuku.co.jp/developers/run_google_colaboratory_notebooks_on_local_machine


# 参考
- https://qiita.com/radiol/items/48909d69ba8114edcbf2
- https://qiita.com/ttsubo/items/c97173e1f04db3cbaeda
- https://www.kabuku.co.jp/developers/run_google_colaboratory_notebooks_on_local_machine

