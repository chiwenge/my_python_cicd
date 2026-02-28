FROM python:3.13-slim


# 设置工作目录
WORKDIR /app

# 使用阿里云镜像源
RUN rm -f /etc/apt/sources.list.d/* \
    && echo "deb https://mirrors.aliyun.com/debian/ bookworm main contrib non-free" > /etc/apt/sources.list \
    && echo "deb https://mirrors.aliyun.com/debian/ bookworm-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb https://mirrors.aliyun.com/debian/ bookworm-backports main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb https://mirrors.aliyun.com/debian-security bookworm-security main contrib non-free" >> /etc/apt/sources.list

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    wget \
    gnupg2 \
    curl \
    chromium \
    chromium-driver \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-freefont-ttf \
    libxss1 \
    xvfb \
    dbus \
    dbus-x11 \
    && rm -rf /var/lib/apt/lists/*

# 创建缓存目录
RUN mkdir -p /app/cache && chmod 777 /app/cache

# 复制项目文件
COPY requirements.txt .
COPY app app/

# 使用清华 PyPI 镜像源安装 Python 依赖
RUN pip install --upgrade pip 
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple 
RUN pip install --no-cache-dir -r requirements.txt 
RUN playwright install chromium --with-deps

# 设置环境变量
ENV DATABASE_URL="sqlite:///./app.db"
ENV MAX_PAGES=8
ENV PYTHONUNBUFFERED=1
ENV DISPLAY=:99
ENV CHROME_PATH=/usr/bin/chromium
ENV PLAYWRIGHT_BROWSERS_PATH=/root/.cache/ms-playwright

# 暴露端口
EXPOSE 8000

# 启动命令
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]