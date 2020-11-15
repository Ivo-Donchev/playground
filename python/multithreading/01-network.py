import time
import requests
import threading


def run():
    for i in range(30):
        requests.get('http://abv.bg')


def run_async():
    threads = []

    for i in range(30):
        thread = threading.Thread(target=requests.get, args=('http://abv.bg',))
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
    run()
    print('Without threads: ' , time.time() - start)

    start = time.time()
    run_async()
    print('With threads: ' , time.time() - start)

if __name__ == '__main__':
    main()
