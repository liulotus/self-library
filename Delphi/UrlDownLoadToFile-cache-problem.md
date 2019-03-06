`UrlDownloadToFile` 下载文件前先在本地缓存中查找该文件，如果缓存有则不去网上抓取新文件，如果要每次都下载新的文件，有两种方法来处理。

方法一：

可以对 `URL` 进行改动，每次访问不同的 `URL` ，但指向相同的页面。例如：在 `URL` 末尾增加一些无意义的参数。

`http://www.example.com?download=abc`

这里的 `download=abc` 可以随机实现。

方法二：

在使用 `UrlDownloadToFile` 前使用 `DeleteUrlCacheEntry(url)` ，然后再使用 `UrlDownloadToFile`。
