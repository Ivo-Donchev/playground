import time
import requests
import multiprocessing


def cpu_heavy():
    # String heavy operation
    result = ''

    for i in range(1000000):
        result += 'a'


def run():
    for i in range(50):
        cpu_heavy()


def run_async():
    processes = []
    for i in range(50):
        process = multiprocessing.Process(target=cpu_heavy)
        process.start()
        processes.append(process)

    for process in processes:
        process.join()


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
