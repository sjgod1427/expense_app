#include <stdio.h>

void selectionSort(int arr[], int n) {
    int i, j, minIdx, temp;
    for (i = 0; i < n-1; i++) {
        minIdx = i;
        for (j = i+1; j < n; j++) {
            if (arr[j] < arr[minIdx]) {
                minIdx = j;
            }
        }
        // Swap the found minimum element with the first element
        temp = arr[minIdx];
        arr[minIdx] = arr[i];
        arr[i] = temp;
    }
}

void printAges(int arr[], int n) {
    int i;
    printf("Ages in ascending order:\n");
    for (i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    printf("Three youngest participants:\n");
    for (i = 0; i < 3 && i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    printf("Three oldest participants:\n");
    for (i = n-1; i >= n-3 && i >= 0; i--) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

void insertionsort(int n, int arr[]) {
    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j = i - 1;

        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
}

void bubbleSort(int arr[], int n) {
    int c = 0;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
                ++c;
            }
        }
    }
    printf("Number of swaps: %d\n", c);
}

void heapify(int arr[], int n, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < n && arr[left] < arr[smallest])
        smallest = left;

    if (right < n && arr[right] < arr[smallest])
        smallest = right;

    if (smallest != i) {
        int temp = arr[i];
        arr[i] = arr[smallest];
        arr[smallest] = temp;

        heapify(arr, n, smallest);
    }
}

int deleteRoot(int arr[], int *n) {
    if (*n <= 0) {
        printf("Heap is empty!\n");
        return -1;
    }

    int root = arr[0];

    arr[0] = arr[*n - 1];
    (*n)--;

    heapify(arr, *n, 0);

    return root;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maximizeRemovedSum(int N, int K, int stack[]) {
    int maxSum = 0;

    for (int i = 0; i <= K; i++) {
        int sum = 0;

       
        for (int j = 0; j < i; j++) {
            sum += stack[j];
        }

        for (int j = 0; j < K - i; j++) {
            sum += stack[N - 1 - j];
        }

        maxSum = max(maxSum, sum);
    }

    return maxSum;
}

int main() {
    int arr[] = {12, 11, 13, 5, 6};
    int n = sizeof(arr) / sizeof(arr[0]);


    insertionsort(n, arr);

    printf("Sorted array using Insertion Sort: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");


    bubbleSort(arr, n);

    
    deleteRoot(arr, &n);

    printf("Array after deleteRoot operation: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    int stack[] = {12, 11, 13, 5, 6};
    int N = sizeof(stack) / sizeof(stack[0]);
    int K = 3; // Example value for K
    int maxSum = maximizeRemovedSum(N, K, stack);
    printf("Maximum sum of removed elements: %d\n", maxSum);

   
    int ages[] = {25, 30, 18, 22, 40, 33};
    int participants = sizeof(ages) / sizeof(ages[0]);

    selectionSort(ages, participants);
    printAges(ages, participants);

    return 0;
}
