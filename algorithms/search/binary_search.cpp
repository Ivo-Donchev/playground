#include <iostream>

using namespace std;


void printArr(int *arr, int size)
{
  for(int i = 0; i < size; i++)
  {
    cout << arr[i] << " ";
  }

  cout << endl;
}


int binarySearch(int* arr, int start, int end, int element)
{
  const int size = end - start + 1,
            middleIndex = start + (size / 2);

  if(size == 0)
    return -1;

  if(size == 1)
    return (arr[start] == element) ? start: -1;

  if(arr[middleIndex] > element)
    return binarySearch(arr, start, middleIndex - 1, element);

  else if(arr[middleIndex] < element)
    return binarySearch(arr, middleIndex, end, element);

  return middleIndex;

}

int main()
{
  const int size = 10;
  int *arr = new int [size];

  for(int i = 0; i < size; i++)
    arr[i] = i + 1;

  printArr(arr, size);

  for(int i=-5;i<size + 5;i++)
    cout << i + 1 << "  =>  " << binarySearch(arr, 0, 9, i + 1) << endl;


  return 0;
}
