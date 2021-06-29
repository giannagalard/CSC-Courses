class Solution {
    public:
        int minOperations(vector < int > & nums) {
            int count = 0;
            for (int i = 1; i < nums.size(); i++) {
                if (nums[i] <= nums[i - 1]) {
                    int inc = nums[i - 1] - nums[i] + 1;
                    count += inc;
                    nums[i] += inc;
                }
        }
    return count;
}
};