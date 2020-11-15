import time
import requests
import threading


def with_single_thread():
    for i in range(30):
        print(requests.get('http://abv.bg'))


def with_multiple_threads():
    threads = []

    for i in range(30):
        thread = threading.Thread(target=lambda url: print(requests.get(url)), args=('http://abv.bg',))
        thread.start()
        threads.append(thread)

    for thread in threads:
        thread.join()


# Class based example
class RunAsync(threading.Thread):
    def run(self):
        res=  requests.get('http://abv.bg')
        print(res)


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
