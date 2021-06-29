class Solution {
    public:
        int maxSubArray(vector < int > & nums) {
            int max_sum = INT_MIN; // neg inf
            int cur_sum = 0;
            for (int i = 0; i < nums.size(); i++) {
                cur_sum += nums[i];
                max_sum = max(max_sum, cur_sum);
                if (cur_sum < 0) { // if the current sum becomes neg
                    cur_sum = 0; // set equal to 0 (kadanes alg)
                }
            }
            return max_sum;
        }
};

// t = 0(n)
// s = 0(1)