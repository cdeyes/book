from fastapi import FastAPI
from fastapi.middleware.trustedhost import TrustedHostMiddleware
import socket
import uvicorn
app = FastAPI()

# 添加信任域名中间件
app.add_middleware(
    TrustedHostMiddleware,
    # 允许访问的域名白名单
    allowed_hosts=["test.com", "www.test.com", "localhost"]
)

@app.get("/")
async def root():
    return {"message": "安全访问"}
@app.get("/home")
async def read_home():
    return {"message": "welcome"}
@app.get("/health_check")
async def read_hc():
    return {"message": "ok"}

def get_hostname() -> str:
    """获取本机主机名"""
    return socket.gethostname()

def get_local_ip() -> str:
    """获取本机内网IP（生产推荐方案）"""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        local_ip = s.getsockname()[0]
        s.close()
        return local_ip
    except Exception:
        return "127.0.0.1"

@app.get("/node-status", summary="节点健康检查接口")
async def node_status():
    return {
        "status": "WEB_OK",
        "hostname": get_hostname(),
        "server_ip": get_local_ip()
    }


