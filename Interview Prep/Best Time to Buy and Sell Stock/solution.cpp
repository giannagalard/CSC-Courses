class Solution {
    public:
        int bestProfit = 0;
    int curProfit;
    int maxProfit(vector < int > & prices) {
        for (int i = 0; i < prices.size(); i++) {
            for (int j = i + 1; j < prices.size(); j++) {
                int curProfit = prices[j] - prices[i];
                if (curProfit > bestProfit)
                    bestProfit = curProfit;
            }
        }
        return bestProfit;
    }
};