import 'dart:async';

class MergeSort {
  static Future<void> sort(
      List<int> array,
      Function(List<int>, Set<int>, {bool isSorted}) updateGraph) async {
       await _mergeSort(array,0,array.length-1,updateGraph);
       updateGraph(List.from(array), {}, isSorted: true);
      }
      static Future<void>_mergeSort(
          List<int>array,
          int left,
          int right,
          Function(List<int>,Set<int>,{bool isSorted})updateGraph)async{
    if(left<right){
      int mid=(left+right)~/2;
      await _mergeSort(array,left,mid,updateGraph);
      await _mergeSort(array,mid+1,right,updateGraph);
      await _merge(array,left,mid,right,updateGraph);
    }
  }
        // Optimize UI update to avoid too many setState() calls


    // Mark all elements as sorted
   static Future<void>_merge(
  List<int>array,
       int left,
       int mid,
       int right,
       Function(List<int>,Set<int>,{bool isSorted})updateGraph)async{
    List<int> leftarray=array.sublist(left,mid+1);
    List<int> rightarray=array.sublist(mid+1,right+1);
    int i=0,j=0,k=left;
    while(i<leftarray.length&&j<rightarray.length){
      updateGraph(List.from(array),{left+i,mid+i+j});
      await Future.delayed(const Duration(milliseconds:200));
      if (leftarray[i] <= rightarray[j]) {
        array[k] = leftarray[i];
        i++;
      } else {
        array[k] = rightarray[j];
        j++;
      }
      k++;
    }
    while (i < leftarray.length) {
      array[k] = leftarray[i];
      i++;
      k++;
    }
    while (j < rightarray.length) {
      array[k] = rightarray[j];
      j++;
      k++;
    }
    updateGraph(List.from(array), {}, isSorted: false);
    await Future.delayed(const Duration(milliseconds: 600));
  }
}