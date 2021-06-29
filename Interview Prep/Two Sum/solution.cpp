class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
    vector<int> results;
    for(int i = 0; i < nums.size(); i++) {
      int search = target - nums[i];
      for(int j = i + 1; j < nums.size(); j++) {
        if(search == nums[j]) {
          results.push_back(i);
          results.push_back(j);
          break;
        }
      }
    }
    return results;
    }
};