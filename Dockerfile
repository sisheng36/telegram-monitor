FROM python:3.11-slim  
  
WORKDIR /app  
  
# 安装系统依赖  
RUN apt-get update && apt-get install -y --no-install-recommends \  
    gcc \  
    && rm -rf /var/lib/apt/lists/*  
  
# 先复制依赖文件，利用 Docker 层缓存  
COPY requirements.txt .  
RUN pip install --no-cache-dir -r requirements.txt  
  
# 复制项目代码  
COPY . .  
  
# 创建持久化目录  
RUN mkdir -p data logs downloads  
  
EXPOSE 8000  
  
CMD ["python", "web_app_launcher.py", "--public"]
