import { createWriteStream, existsSync } from "fs";
import { mkdir } from "fs/promises";
import { Readable } from "stream"
import { ReadableStream } from "stream/web"
import { finished } from "stream/promises"

/**
 * This script is currently made to function developping with a docker container,
 * hence the replacement of `localhost` to the service name `api` for network calls
 * between containers
 */

type ProductImageLocation = {
    name: string;
    url: string;
}

type ProductList = {
    products: ProductImageLocation[]
}

async function main() {
    try {
        if (!existsSync("./static/img/products")) {
            await mkdir("./static/img/products");
        }
        const response = await fetch("http://api:3000/");
        const productList = await response.json() as ProductList;
        const promises = productList.products.map((product) => {
          return downloadImage(product);
        })
        await Promise.all(promises);
    } catch (err) {
        console.error(err)
        throw new Error(`Failed retrieving images from the API`, {cause: err});
    }
}

async function downloadImage(productImage: ProductImageLocation): Promise<void> {
    try {
        const url = productImage.url.replace("localhost", "api");
        const response = await fetch(url);
        if (response.ok && response.body) {
            let writer = createWriteStream(`./static/img/products/${productImage.name}`);
            // Note: casting is temporarily necessary due to a typing issues regarding streams cf: https://github.com/DefinitelyTyped/DefinitelyTyped/discussions/65542
            await finished(Readable.fromWeb(response.body as ReadableStream<Uint8Array>).pipe(writer));
        }
    } catch (err) {
        throw new Error(`failed retrieving image ${productImage.name} at ${productImage.url}`, {cause: err});
    }
}

main()
.then(() => console.log("Success"))
.catch(err => console.error(err))