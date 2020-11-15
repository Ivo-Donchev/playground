import time


def main():
    timeout_seconds = 1

    while True:
        print('Heartbeat')
        time.sleep(timeout_seconds)


if __name__ == '__main__':
    main()
