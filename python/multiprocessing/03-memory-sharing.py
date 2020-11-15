import time
import requests
import multiprocessing

COUNTER = 0


def increase_counter():
    global COUNTER
    print(f'Increasing counter from {COUNTER} to {COUNTER + 1}')
    COUNTER += 1


def main():
    print('Counter at the beginning: ', COUNTER)
    threads = []

    for i in range(50):
        thread = multiprocessing.Process(target=increase_counter)
        thread.start()
        threads.append(thread)

    for thread in threads:
        thread.join()

    print('Counter at the end: ', COUNTER)


if __name__ == '__main__':
    main()
