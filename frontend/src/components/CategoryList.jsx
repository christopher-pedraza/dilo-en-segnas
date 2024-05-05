/* eslint-disable react/prop-types */
import CategoryItem from "./CategoryItem";

function CategoryList({ environment, setEnvironments, navigate }) {
  return (
    <div className="ml-6">
      {environment.categories.map((cat) => (
        <CategoryItem
          key={cat.id}
          category={cat}
          environment={environment}
          setEnvironments={setEnvironments}
          navigate={navigate}
        />
      ))}
    </div>
  );
}

export default CategoryList;
