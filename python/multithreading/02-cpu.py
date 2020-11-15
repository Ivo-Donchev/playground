import time
import requests
import threading

def cpu_heavy():
    asd = ''

    for i in range(1000000):
        asd += 'a'



def run():
    for i in range(50):
        cpu_heavy()

def run_async():
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
    run()
    print('Without threads: ' , time.time() - start)

    start = time.time()
    run_async()
    print('With threads: ' , time.time() - start)


if __name__ == '__main__':
    main()
