class Solution {
    public:
        int maxArea(vector < int > & height) {
            int area = 0;
            for (int i = 0; i <= height.size(); i++) {
                for (int j = i + 1; j < height.size(); j++) {
                    area = max(area, min(height[j], height[i]) * (j - i));
                }
            }
            return area;
        }
};