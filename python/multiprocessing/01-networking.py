import time
import requests
import multiprocessing


def with_single_process():
    for i in range(30):
        print(requests.get('http://abv.bg'))


def with_multiple_processes():
    processes = []

    for i in range(30):
        process = multiprocessing.Process(target=lambda url: print(requests.get(url)), args=('http://abv.bg',))
        process.start()
        processes.append(process)

    for process in processes:
        process.join()


def main():
    print('Running....')

    start = time.time()
    with_single_process()
    print('With 1 process: ' , time.time() - start)

    start = time.time()
    with_multiple_processes()
    print('With multiple processes: ' , time.time() - start)

if __name__ == '__main__':
    main()
