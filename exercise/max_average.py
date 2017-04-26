def maxAverage(nums, k):
    # Write your code here
    l, r = min(nums), max(nums)
    n = len(nums)
    prefix = [0] * (n + 1)
    while r - l >= 1e-6:
        mid, check = (l + r) / 2.0, False
        print(l, r, mid)
        min_pre = 0
        for i in range(1, n + 1):
            prefix[i] = prefix[i - 1] + nums[i - 1] - mid
            if i >= k and prefix[i] >= min_pre:
                check = True
                break
            if i >= k:
                min_pre = min(min_pre, prefix[i - k + 1])

        if check:
            l = mid
        else:
            r = mid
    return l


if __name__ == "__main__":
    nums = [1, 12, -5, -6, 50, 3]
    maxAverage(nums, 3)
