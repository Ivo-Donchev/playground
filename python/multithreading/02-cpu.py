import time
import requests
import threading


def cpu_heavy():
    # String heavy operation
    result = ''

    for i in range(1000000):
        result += 'a'


def with_single_thread():
    for i in range(50):
        cpu_heavy()


def with_multiple_threads():
    threads = []
    for i in range(50):
        thread = threading.Thread(target=cpu_heavy)
        thread.start()
        threads.append(thread)

    for thread in threads:
        thread.join()


def main():
    print('Running....')

    start = time.time()
    with_single_thread()
    print('Without threads: ' , time.time() - start)

    start = time.time()
    with_multiple_threads()
    print('With threads: ' , time.time() - start)


if __name__ == '__main__':
    main()
