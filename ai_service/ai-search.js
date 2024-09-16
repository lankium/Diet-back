// nlp 相似性搜索
const { client } = require('./app.service.js'); // 动态导入 ES 模块


// 计算向量的余弦相似度
const cosineSimilarity = (v1, v2) => {
  // 计算向量的点积
  const dotProduct = v1.reduce((acc, curr, i) => acc + curr * v2[i], 0);

  // 计算向量的长度
  const lengthV1 = Math.sqrt(v1.reduce((acc, curr) => acc + curr * curr, 0));
  const lengthV2 = Math.sqrt(v2.reduce((acc, curr) => acc + curr * curr, 0));

  // 计算余弦相似度
  const similarity = dotProduct / (lengthV1 * lengthV2);

  return similarity;
};

const aiSearch = async (search_text, recipes) => {
  try {
    const response = await client.embeddings.create({
      model: 'text-embedding-ada-002',
      input: search_text
    });
    const { embedding } = response.data[0];
    const recipesWithEmbedding = [];
    for (const { recipe_id, title, description } of recipes) {
      const responses = await client.embeddings.create({
        model: 'text-embedding-ada-002',
        input: `菜单:${title} 描述:${description}`
      });
      recipesWithEmbedding.push({
        recipe_id,
        title,
        description,
        embedding: responses.data[0].embedding
      });
    }
    const results = recipesWithEmbedding.map(item => ({
      ...item,
      similarity: cosineSimilarity(embedding, item.embedding)
    }))
      .sort((a, b) => a.similarity - b.similarity)
      .reverse()
    const simplifiedResults = results.map(({ recipe_id, title }) => ({
      recipe_id,
      title,
    }));
    return simplifiedResults;
  } catch (error) {
    console.error('Error in aiSearch:', error);
  }
};

module.exports = { aiSearch };

// 示例调用
// aiSearch('烤鸡', [
//   { title: '炸鸡', description: '美味的炸鸡' },
//   { title: '美味的炸鸡', description: '酥脆可口的炸鸡' }
// ]).then(results => {
//   console.log('Search Results:', results);
// });