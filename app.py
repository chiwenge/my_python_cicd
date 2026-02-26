def add(a, b):
    return a + b


def subtract(a, b):    # 函数之间要空2行
    return a - b


def multiply(a, b):    # 函数之间要空2行
    return a * b


def divide(a, b):      # 函数之间要空2行
    if b == 0:
        raise ValueError("除数不能为0")
    return a / b


if __name__ == "__main__":    # 函数和主程序之间也要空2行
    print("简单计算器")
    print(f"10 + 5 = {add(10, 5)}")
    print(f"10 - 5 = {subtract(10, 5)}")
    print(f"10 × 5 = {multiply(10, 5)}")
    print(f"10 ÷ 5 = {divide(10, 5)}")

# 文件末尾要有一个空行（非常重要！）
