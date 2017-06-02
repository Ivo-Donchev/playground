#include <iostream>


using namespace std;


void swap(int& a, int& b)
{
  int c = a;
  a = b;
  b = c;
}


void printArr(int *arr, int size)
{
  for(int i = 0; i < size; i++)
  {
    cout << arr[i] << " ";
  }

  cout << endl;
}


void insertionSort(int* arr, int size)
{
  for(int i = 0; i < size - 1; i++)
  {
    for(int j = i + 1; j < size; j++)
    {
      if(arr[i] > arr[j])
      {
        int k = j;

        while(k)
        {
          swap(arr[k], arr[k-1]);
          k--;
        }
      }
    }
  }
}


void bubbleSort(int* arr, int size)
{

  for(int i = 0; i < size - 1; i++)
  {
    int min = i;

    /* Find the index if min element */
    for(int j = i + 1; j < size; j++)
    {
      if(arr[j] < arr[min])
      {
        min = j;
      }
    }

    while(min - i)
    {
      swap(arr[min], arr[min-1]);
      min--;
    }
  }
}

void selectionSort(int* arr, int size)
{
  for(int i = 0; i < size - 1; i++)
  {
    int min = i;

    /* Find the index if min element */
    for(int j = i + 1; j < size; j++)
    {
      if(arr[j] < arr[min])
      {
        min = j;
      }
    }
    swap(arr[i], arr[min]);
  }
}


int main()
{
  const int size = 30;
  int* arr = new int [size];
  for(int i = 0; i < size; i++)
  {
    arr[i] = size - i;
  }

  printArr(arr, (int)size);
  selectionSort(arr, (int)size);


  return 0;
}
